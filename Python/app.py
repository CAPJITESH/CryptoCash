from flask import Flask, request, jsonify
from web3 import Web3

app = Flask(__name__)

ganache_url = "http://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

print(web3.isconnected())
if __name__ == '__main__':
    app.run(debug=True)
