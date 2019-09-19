peer channel create -o orderer.example.com:7050 -c channel12 -f ../channel-artifacts/channel12.tx

peer channel join -b channel12.block -o orderer.example.com:7050

peer chaincode install -n stress -v 1.0 -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/stress-test

peer chaincode instantiate -o orderer.example.com:7050 -C channel12 -n stress -l node -v 1.0 -c '{"function":"initLedger","Args":[]}' -P "OR ('Org1MSP.member','Org2MSP.member')"
