# ens.lll build scripts

This directory contains a dockerfile that allows you to verify the ENS contract deployed at [0x518232dd973C321107D28Cb11483b857b9A1E158](https://explorer.ellaism.org/account/0x518232dd973C321107D28Cb11483b857b9A1E158) corresponds to the source code.

To use it, first examine the Dockerfile to verify it's doing what you think it is. Then, from the main directory run:

    docker build --tag=lllc .
    docker run -v $PWD:/ens lllc:latest -x /ens/ens.lll > ens.lll.bin

Examine the content in `ens.lll.bin` corresponds to the contract creation transaction at [0x6f5c491ff02713b3bf7c7edbe7ba9cbba8c6a39773356a96c7a87af59c238ebf](https://explorer.ellaism.org/tx/0x6f5c491ff02713b3bf7c7edbe7ba9cbba8c6a39773356a96c7a87af59c238ebf).
