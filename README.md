# PaVM
The source code of PaVM, a smart contract virtual machine that supports inter- and inner-parallel execution.

## Get started

```shell
# enable compile.sh executable
chmod +x compile.sh

# compile PaVM
./compile.sh
```

## Introduction

### Key instructions

The newly added instructions in PaVM is listed as follows:

Type|Mnemonic|Opcode|Context
---|---|---|---
Thread|control|SUBSOL|0xA1|PUSH,|PUSH
Thread|control|SLEEP|0xA2|PUSH,|PUSH
Thread|control|REVERTT|0xA3|PUSH
Data|control|AFTERW|0xA4|PUSH,|MLOAD
Data|control|AFTERR|0xA5|PUSH,|MLOAD
Data|control|AFTERA|0xA6|PUSH,|MLOAD
Runtime|record|RR|0xA7|PUSH,|MLOAD
Runtime|record|RPHASH|0xA8|PUSH,|MLOAD
Runtime|record|RDR|0xA9|PUSH
Runtime|record|WTR|0xAA|PUSH

The implementation of each instruction obeies the following code:

```golang
func op[insturction_name] (ret) {stack..}{
  // get the args from VM Stack
  // instruction specific logic
  // return value
}
```

### New data area

PaVM provides several data areas to store the multithread-related data as follows:

- Thread Data
- Record Data
- Thread State Table

Besides, PaVM also supports typical areas such as:

- Stack
- Persistent Storage
