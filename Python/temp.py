from web3 import Web3
ganache_url = "http://127.0.0.1:8545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

print(web3.is_connected())

ganache_url = "http://127.0.0.1:8545"
web3 = Web3(Web3.HTTPProvider(ganache_url))

target_address = web3.to_checksum_address('0x5FbDB2315678afecb367f032d93F642f64180aa3')
abi = '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"bytes32","name":"_txHash","type":"bytes32"},{"internalType":"address","name":"_sender","type":"address"},{"internalType":"address","name":"_receiver","type":"address"},{"internalType":"uint256","name":"_amount","type":"uint256"},{"internalType":"string","name":"_name","type":"string"}],"name":"addTransaction","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_account","type":"address"}],"name":"getAllTransactionsForAccount","outputs":[{"components":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"address","name":"receiver","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"string","name":"name","type":"string"}],"internalType":"struct UserRegistry.Transaction[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"_txHash","type":"bytes32"}],"name":"getTransactionName","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"_userAddress","type":"address"}],"name":"getUserName","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"_txHash","type":"bytes32"},{"internalType":"string","name":"_name","type":"string"}],"name":"setTransactionName","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"_userAddress","type":"address"},{"internalType":"string","name":"_name","type":"string"}],"name":"setUserName","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"transactionKeys","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"name":"transactionNames","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"name":"transactions","outputs":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"address","name":"receiver","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"string","name":"name","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"userNames","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"}]'
target = web3.eth.contract(address= target_address, abi = abi)



private_key = "cd590944a5c6479345a40d67f53a4248a377c3cdd9504566b1f4b25c89d04f42"
account = web3.eth.account.from_key(private_key)

acc1 = '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266'
p1 = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

def set_user_name(name):
    try: 
        tx_hash = target.functions.setUserName(account.address, name).transact({'from': acc1})
        return tx_hash.hex()
    except Exception as e:
        print(e)
        return 'error'


def get_user_name():
    try:
        name = target.functions.getUserName(account.address).call()
        print(name)
        return name
    except Exception as e:
        print(e)

        return "error"
    
def get_all_transactions_for_account(account_address):
    try:
        transactions = []
        # Get all transactions for the specified account address
        for tx_hash in target.functions.getAllTransactionsForAccount(account_address).call():
            sender = target.functions.transactions(tx_hash)['sender'].call()
            receiver = target.functions.transactions(tx_hash)['receiver'].call()
            amount = target.functions.transactions(tx_hash)['amount'].call()
            name = target.functions.transactions(tx_hash)['name'].call()
            transactions.append({'from': sender, 'to': receiver, 'amt': amount, 'name': name})
        return transactions
    except Exception as e:
        print(e)
        return []

# Example usage:
account_address = "0x1234567890123456789012345678901234567890"  # Replace with the account address you want to query
transactions = get_all_transactions_for_account(account_address)
for tx in transactions:
    print("From:", tx['from'])
    print("To:", tx['to'])
    print("Amt:", tx['amt'])
    print("Name:", tx['name'])
    
# print(set_user_name('Jitesh'))
# print(get_user_name())

        
# private_key = "cd590944a5c6479345a40d67f53a4248a377c3cdd9504566b1f4b25c89d04f42"


# account = web3.eth.account.from_key(private_key)

# print("Address:", account.address)
# print("Private Key:", private_key)




# acc2 = web3.eth.account.from_key('76f41de1637335b1a60db3514781809350713cdfb0c8df6c80366b319d923228').address

# p2 = "76f41de1637335b1a60db3514781809350713cdfb0c8df6c80366b319d923228"

# nonce = web3.eth.get_transaction_count(account.address)

# t = web3.eth.get_balance(account.address)

# print(web3.from_wei(web3.eth.get_balance(acc2), 'ether'), "account 2")

# print(web3.from_wei(t, "ether"), "Account 1")
# tx = {
#     'nonce': nonce,
#     'to': acc2,
#     'value': web3.to_wei(100, 'ether'),
#     'gas': 2000000,
#     'gasPrice': web3.to_wei('50', 'gwei'),
# }



# # # tempstring  = '''
# # # flutter: Mne : market review actor clown blouse infant envelope regular amused torch panic feature
# # # flutter: pri : ce2c7b0b166145d6830e0b60f6009038a7d7b08751c5ea1095662c62e2bf977b
# # # flutter: Public : 0xa94a39901b262ffc4918fb1b49f522120dd6f224
# # # '''


# tempa = '''flutter: Mne : abandon impact label three upgrade kidney tattoo lizard size cube salon bubble
# flutter: pri : 76f41de1637335b1a60db3514781809350713cdfb0c8df6c80366b319d923228
# flutter: Public : 0x7d5485b9b23b58e8778fdc989294c0a872dbdfdf'''

# signed_tx = web3.eth.account.sign_transaction(tx, private_key)

# tx_hash = web3.eth.send_raw_transaction(signed_tx.rawTransaction)

# print(web3.to_hex(tx_hash))

# print(web3.from_wei(web3.eth.get_balance(account.address), "ether"))
# print(web3.from_wei(web3.eth.get_balance(acc2), 'ether'), "account 2")