# What is the locking script in this transaction
transaction="0200000001d54e767769b3c3b8707115f748c88f7323def5b78147628aa071fdcf2fdf7379000000006a47304402207883e621fb279d18902986836e89ebe77c13b39e7c9141d0c8b81274a98245d502204d3ffc75ae16b8d3e5918f078075cb2afb180828d910f0feaf090cd74d805ca4012103fdee3ce1c3ca71b5e9eb846147ff5d26f499ef2f12f84b34de46b3dcf228df55fdffffff0180e0d211010000001976a914d5391484579a9760f87c9772035248325aabe01f88ac00000000"

# THE LOCKING SCRIPT IS SCRIPT WHICH IS RUN TO LOCK THE UTXOs TO THE PUBLIC KEY OF THE RECIPIENT ADDRESS
# LOCKING SCRIPT IS LOCATED IN THE VOUTS OF THE DECODED TRANSACTION SCRIPTPUBKEY OBJECT ON THE HEX KEY

LOCKING_SCRIPT=$(bitcoin-cli -regtest -named decoderawtransaction hexstring=$transaction | jq -r '.vout[0].scriptPubKey.hex')

echo $LOCKING_SCRIPT