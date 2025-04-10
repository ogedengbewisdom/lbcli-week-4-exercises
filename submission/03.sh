# Create a raw transaction and add this message in it: "btrust builder 2025"

# Amount of 20,000,000 satoshis to this address: 2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP 
# Use the UTXOs from the transaction below
# transaction="01000000000101c8b0928edebbec5e698d5f86d0474595d9f6a5b2e4e3772cd9d1005f23bdef772500000000ffffffff0276b4fa0000000000160014f848fe5267491a8a5d32423de4b0a24d1065c6030e9c6e000000000016001434d14a23d2ba08d3e3edee9172f0c97f046266fb0247304402205fee57960883f6d69acf283192785f1147a3e11b97cf01a210cf7e9916500c040220483de1c51af5027440565caead6c1064bac92cb477b536e060f004c733c45128012102d12b6b907c5a1ef025d0924a29e354f6d7b1b11b5a7ddff94710d6f0042f3da800000000"

RECIPIENT_ADDRESS="2MvLcssW49n9atmksjwg2ZCMsEMsoj3pzUP"

# AMOUNT IN BITCOIN
AMOUNT=0.2

DECODED_TRANSACTION=$(bitcoin-cli -regtest -named decoderawtransaction hexstring=$transaction)

UTXO_TXID=$(echo $DECODED_TRANSACTION | jq -r '.txid')
UTXO_VOUT_1=$(echo $DECODED_TRANSACTION | jq -r '.vout[0].n')
UTXO_VOUT_2=$(echo $DECODED_TRANSACTION | jq -r '.vout[1].n')
HASHED_MESSAGE=$(echo -n "btrust builder 2025" | sha256sum | cut -d' ' -f1)

RAW_TRANSACTION_HEX=$(bitcoin-cli -regtest -named createrawtransaction inputs='''[ { "txid": "'$UTXO_TXID'", "vout": '$UTXO_VOUT_1' }, { "txid": "'$UTXO_TXID'", "vout": '$UTXO_VOUT_2' } ]''' outputs='''{ "data":"'$HASHED_MESSAGE'" ,"'$RECIPIENT_ADDRESS'": '$AMOUNT' }''')

echo $RAW_TRANSACTION_HEX