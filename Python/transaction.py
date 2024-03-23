from web3 import Web3
ganache_url = "http://127.0.0.1:7545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

print(web3.is_connected())

private_key = "7dad0a772e306a14c6fefac52e5854d16a0b547af934e3aa4434f55eff09503a"


account = "0xECa1615d8806d19C88d926Ed21A4a98E3D95e6f5"


acc2 = "0xE771A4392Cb3876Be521000873d4D508922Cec29"

p2 = "76f41de1637335b1a60db3514781809350713cdfb0c8df6c80366b319d923228"

nonce = web3.eth.get_transaction_count(account)

t = web3.eth.get_balance(account)

print(web3.from_wei(web3.eth.get_balance(acc2), 'ether'), "account 2")

print(web3.from_wei(t, "ether"), "Account 1")
tx = {
    'nonce': nonce,
    'to': acc2,
    'value': web3.to_wei(0.1, 'ether'),
    'gas': 2000000,
    'gasPrice': web3.to_wei('50', 'gwei'),
}

signed_tx = web3.eth.account.sign_transaction(tx, private_key)

tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)

print(web3.to_hex(tx_hash))