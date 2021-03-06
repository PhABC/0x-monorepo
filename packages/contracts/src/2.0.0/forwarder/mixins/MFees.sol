/*

  Copyright 2018 ZeroEx Intl.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

pragma solidity 0.4.24;


contract MFees {

    /// @dev Pays the feeRecipient feeProportion of the total takerEthAmount, denominated in ETH
    /// @param takerEthAmount The total amount that was transacted in WETH, fees are calculated from this value.
    /// @param feeProportion The proportion of fees
    /// @param feeRecipient The recipient of the fees
    /// @return ethFeeAmount Amount of ETH paid to feeRecipient as fee.
    function payEthFee(
        uint256 takerEthAmount,
        uint16 feeProportion,
        address feeRecipient
    )
        internal
        returns (uint256 ethFeeAmount);

    /// @dev Withdraws the remaining WETH, deduct and pay fees from this amount based on the takerTokenAmount to the feeRecipient.
    ///      If a user overpaid ETH initially, the fees are calculated from the amount traded and deducted from withdrawAmount.
    ///      Any remaining ETH is sent back to the user.
    /// @param ethWithdrawAmount The amount to withdraw from the WETH contract.
    /// @param wethAmountSold The total amount that was transacted in WETH, fees are calculated from this value.
    /// @param feeProportion The proportion of fees
    /// @param feeRecipient The recipient of the fees
    function withdrawPayAndDeductEthFee(
        uint256 ethWithdrawAmount,
        uint256 wethAmountSold,
        uint16 feeProportion,
        address feeRecipient
    )
        internal;

    /// @dev Checks whether the amount of tokens sold against the amount of tokens requested
    ///      is within a certain threshold. This ensures the caller gets a fair deal when
    ///      performing any token fee abstraction. Threshold is 95%. If fee abstraction costs more than
    ///      5% of the total transaction, we return false.
    /// @param requestedSellAmount The amount the user requested, or sent in to a payable function
    /// @param tokenAmountSold The amount of the token that was sold after fee abstraction
    /// @return bool of whether this is within an acceptable threshold
    function isAcceptableThreshold(uint256 requestedSellAmount, uint256 tokenAmountSold)
        internal
        pure
        returns (bool);
}
