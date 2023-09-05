git clone https://github.com/ethereum/go-ethereum

cp -r src/ ./go-ethereum/

cd ./go-ethereum

make geth

echo "Compile & install PaVM successfully."

echo "Now you can run `./geth` to use Geth client with PaVM."
