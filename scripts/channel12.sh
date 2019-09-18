peer channel create -o orderer.example.com:7050 -c channel12 -f ../channel-artifacts/channel12.tx

peer channel join -b channel12.block -o orderer.example.com:7050

peer chaincode install -n shrim -v 1.0 -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/shrim

peer chaincode instantiate -o orderer.example.com:7050 -C channelall -n shrim -l node -v 1.0 -c '{"Args":[""]}' -P "OR ('Org1MSP.member','Org2MSP.member')"
