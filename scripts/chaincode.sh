peer channel create -o orderer.example.com:7050 -c channelall -f ../channel-artifacts/channelall.tx

peer channel join -b channelall.block

peer chaincode install -n stress -v 1.0 -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/stress-test

peer chaincode instantiate -o orderer.example.com:7050 -C channelall -n stress -l node -v 1.0 -c '{"function":"initLedger","Args":[]}' -P "OR ('Org1MSP.member','Org2MSP.member','Org3MSP.member','Org4MSP.member')"

