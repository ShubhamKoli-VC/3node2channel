#Channel Name
export CHANNEL_NAME=channelall

#fetching the configuration block
peer channel fetch config config_block.pb -o orderer.example.com:7050 -c $CHANNEL_NAME

#Conver the configuration to JSON and Trim it down
configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config > config.json

#Add the Org4 Crypto Material
jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"Org4MSP":.[1]}}}}}' config.json ./crypto-config/org4.json > modified_config.json

configtxlator proto_encode --input config.json --type common.Config --output config.pb

configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb

configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output org4_update.pb

configtxlator proto_decode --input org4_update.pb --type common.ConfigUpdate | jq . > org4_update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"channelall", "type":2}},"data":{"config_update":'$(cat org4_update.json)'}}}' | jq . > org4_update_in_envelope.json

configtxlator proto_encode --input org4_update_in_envelope.json --type common.Envelope --output org4_update_in_envelope.pb

#Sign and Submit the Config Update
peer channel signconfigtx -f org4_update_in_envelope.pb

export CORE_PEER_LOCALMSPID="Org2MSP"

export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt

export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp

export CORE_PEER_ADDRESS=peer0.org2.example.com:7051

peer channel update -f org4_update_in_envelope.pb -c channelall -o orderer.example.com:7050