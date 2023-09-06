# PaVM

Hello there!

This repo is created for publishing the source code of PaVM, a smart contract virtual machine that supports inter- and inner-contract parallel execution.

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

The implementation of the above areas can be found in /core/vm/ folder.

Besides, PaVM also supports typical areas such as:

- Stack
- Persistent Storage

## Enable parallel!

### Key interfaces for developer

The features such as multithreading can be enabled by interfaces/keywords provided by PaVM:

<img width="301" alt="image" src="https://github.com/nkfyz/PaVM/assets/62918515/78014960-bd69-4b7b-8f23-1bde16b3b878">

Have a try with this demo contract:

```solidity
contract WordCount {
  function count(string textSegment) {
    mapping string[int] ret;
    for(int i = 0; i < len(textSegment); i++) {
      string word = textSegment[i];
      ret[word] == NULL ? ret[word] = 0 : ret[word]++;
    }
    return ret;
}
11
12 /* Enable runtime record and hash computing in main function */
13 function rr rphash main(string text) {
14 int length = len(text);
15
16 mapping tempRet1 = subsol [1] count(text[0 : length/2]);
17 mapping tempRet2 = subsol [2] count(text[length/2 : length]);
18 sleep [1] 1000; // No.1 thread sleeps for 1000ms
19 revertt [2]; // Revert the operations made by No.2 thread
20
21 /* Join the two temporary values by embedded function */
22 return join(tempRet1, tempRet2);
23 }
24 }
```



