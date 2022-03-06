# coding=utf-8
from twisted.internet.protocol import Protocol, Factory
from twisted.internet import reactor
import json
import os
import threading as thd
import time


class IphoneChat(Protocol):
    def connectionMade(self):
        # self.transport.write("""connected""")
        self.factory.clients.append(self)

        print("clients are ", self.factory.clients)


    def connectionLost(self, reason):
        self.factory.clients.remove(self)

    def dataReceived(self, data):
        msg = json.loads(data)
        print("data is ", msg)
        returnmsg = "roger"

        for c in self.factory.clients:
            c.message(returnmsg)

    def message(self, message):
        #此处python3 python2要注意出来str bytes
        self.transport.write(bytes(message.encode('utf-8')))



factory = Factory()
factory.protocol = IphoneChat
factory.clients = []

reactor.listenTCP(8888, factory)
print("Iphone Chat server started")
reactor.run()
