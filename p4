import hashlib, json, time

chain, transactions = [], []

def create_block(nonce, prev_hash):
    block = {
        'index': len(chain) + 1, 
        'time': time.time(), 
        'tx': transactions[:], 
        'nonce': nonce, 
        'prev_hash': prev_hash
    }
    transactions.clear()
    block['hash'] = hashlib.sha256(json.dumps(block, sort_keys=True).encode()).hexdigest()
    chain.append(block)

def new_tx():
    transactions.append({
        'amt': input("Amount: "), 
        'sender': input("Sender: "), 
        'recipient': input("Recipient: ")
    })

def proof_of_work(prev_hash):
    nonce, hash_val = 0, ""
    while not hash_val.startswith('0000'):
        nonce += 1
        hash_val = hashlib.sha256(f"{prev_hash}{nonce}".encode()).hexdigest()
    return nonce

create_block(123, 'genesis')

for _ in range(2):
    for _ in range(int(input("Transactions: "))): 
        new_tx()
        nonce = proof_of_work(chain[-1]['hash'])
        create_block(nonce, chain[-1]['hash'])

print(json.dumps(chain, indent=2))
