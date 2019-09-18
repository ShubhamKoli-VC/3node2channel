/*
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const stressTest = require('./lib/stresstest');

module.exports.stressTest = stressTest;
module.exports.contracts = [stressTest];
