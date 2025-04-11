from flask import Flask, request, jsonify
import hashlib, base58

app = Flask(__name__)

def generate_brain_wallet(username):
    hash_val = hashlib.sha256(username.encode()).digest()
    return base58.b58encode(hash_val).decode(), hash_val.hex()

@app.route('/')
def index():
    return "Welcome to the Brain Wallet Generator"

@app.route('/wallet', methods=['POST'])
def wallet():
    if request.is_json:
        username = request.get_json().get('username')
        addr, pk = generate_brain_wallet(username)
        return jsonify({"username": username, "address": addr, "private_key": pk})

if __name__ == '__main__':
    app.run(debug=True, port=3000)
