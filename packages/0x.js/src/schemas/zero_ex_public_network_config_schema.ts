const networkNameToId: { [networkName: string]: number } = {
    mainnet: 1,
    ropsten: 3,
    rinkeby: 4,
    kovan: 42,
    ganache: 50,
};

export const zeroExPublicNetworkConfigSchema = {
    id: '/ZeroExPublicNetworkConfig',
    properties: {
        networkId: {
            type: 'number',
            enum: [
                networkNameToId.mainnet,
                networkNameToId.ropsten,
                networkNameToId.rinkeby,
                networkNameToId.kovan,
                networkNameToId.ganache,
            ],
        },
        gasPrice: { $ref: '/Number' },
        zrxContractAddress: { $ref: '/Address' },
        exchangeContractAddress: { $ref: '/Address' },
        erc20ProxyContractAddress: { $ref: '/Address' },
        erc721ProxyContractAddress: { $ref: '/Address' },
        orderWatcherConfig: {
            type: 'object',
            properties: {
                pollingIntervalMs: {
                    type: 'number',
                    minimum: 0,
                },
                numConfirmations: {
                    type: 'number',
                    minimum: 0,
                },
            },
        },
    },
    type: 'object',
    required: ['networkId'],
};
