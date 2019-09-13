/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const {
    Contract
} = require('fabric-contract-api');

class stressTest extends Contract {

    async initLedger(ctx) {
        console.info('============= START : Initialize Ledger ===========');
        const intitalEntry = {
            key: 'I am the first entry'
        }
        await ctx.stub.putState('firstEntry', Buffer.from(JSON.stringify(intitalEntry)));

        console.info('============= END : Initialize Ledger ===========');
    }

    async createContract(ctx, uniqueId, key) {
        console.info('============= START : Create Contract ===========');
        console.log(ctx);

        const Transaction = {
            key
        };
        try {
            await ctx.stub.putState(uniqueId, Buffer.from(JSON.stringify(Transaction)));
        } catch (error) {
            console.log(error)
            throw new Error({
                status: '500',
                error: error
            })
        }
    }
}

module.exports = stressTest;
