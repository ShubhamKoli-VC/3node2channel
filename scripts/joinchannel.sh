#To be tun by the peers who have not installed chaincode or joined channel


peer chaincode install -n stress -v 1.0 -l node -p /opt/gopath/src/github.com/hyperledger/fabric/peer/channel-artifacts/stress-test

peer channel fetch 0 channelall.block -o orderer.example.com:7050 -c channelall

peer channel join -b channelall.block