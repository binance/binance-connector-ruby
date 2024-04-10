# Changelog

## 1.5.0 - 2024-04-10

### Added
- Support Ruby 3.2 and 3.3
- New endpoint for Simple Earn:
  - `GET /sapi/v1/simple-earn/flexible/list` to query available Simple Earn flexible product list
  - `GET /sapi/v1/simple-earn/locked/list` to query available Simple Earn locked product list
  - `POST /sapi/v1/simple-earn/flexible/subscribe` to subscribe to a flexible product
  - `POST /sapi/v1/simple-earn/locked/subscribe` to subscribe to a locked product
  - `POST /sapi/v1/simple-earn/flexible/redeem` to redeem a flexible product
  - `POST /sapi/v1/simple-earn/locked/redeem` to redeem a locked product
  - `GET /sapi/v1/simple-earn/flexible/position` to get a flexible product position
  - `GET /sapi/v1/simple-earn/locked/position` to get a locked product position
  - `GET /sapi/v1/simple-earn/account` to get a simple account balances
  - `GET /sapi/v1/simple-earn/flexible/history/subscriptionRecord` to get flexible subscription records
  - `GET /sapi/v1/simple-earn/locked/history/subscriptionRecord` to get locked subscription records
  - `GET /sapi/v1/simple-earn/flexible/history/redemptionRecord` to retrieve flexible redemption records
  - `GET /sapi/v1/simple-earn/locked/history/redemptionRecord` to retrieve locked redemption records
  - `GET /sapi/v1/simple-earn/flexible/history/rewardsRecord` to get flexible rewards history
  - `GET /sapi/v1/simple-earn/locked/history/rewardsRecord` to get locked rewards history
  - `POST /sapi/v1/simple-earn/flexible/setAutoSubscribe` to set an auto-subscription to a flexible product
  - `POST /sapi/v1/simple-earn/locked/setAutoSubscribe` to set an auto-subscription to a locked product
  - `GET /sapi/v1/simple-earn/flexible/personalLeftQuota` to get flexible personal left quota
  - `GET /sapi/v1/simple-earn/locked/personalLeftQuota` to get locked personal left quota
  - `GET /sapi/v1/simple-earn/flexible/subscriptionPreview` to get flexible subscription preview
  - `GET /sapi/v1/simple-earn/locked/subscriptionPreview` to get locked subscription previews
  - `GET /sapi/v1/simple-earn/flexible/history/rateHistory` to get a rate history
  - `GET /sapi/v1/simple-earn/flexible/history/collateralRecord` to get collateral records

### Changed
- Update dependencies
- Drop support of Ruby 2.6 and 2.7

### Removed
- Deprecated Savings endpoints:
  - `GET /sapi/v1/lending/daily/product/list`
  - `GET /sapi/v1/lending/daily/userLeftQuota`
  - `POST /sapi/v1/lending/daily/purchase`
  - `GET /sapi/v1/lending/daily/userRedemptionQuota`
  - `POST /sapi/v1/lending/daily/redeem`
  - `GET /sapi/v1/lending/daily/token/position`
  - `GET /sapi/v1/lending/project/list`
  - `POST /sapi/v1/lending/customizedFixed/purchase`
  - `GET /sapi/v1/lending/union/account`
  - `GET /sapi/v1/lending/union/purchaseRecord`
  - `GET /sapi/v1/lending/union/redemptionRecord`
  - `GET /sapi/v1/lending/union/interestHistory`
  - `GET /sapi/v1/lending/project/position/list`
  - `POST /sapi/v1/lending/positionChanged`

- Deprecated Staking endpoints:
  - `GET /sapi/v1/staking/productList`
  - `POST /sapi/v1/staking/purchase`
  - `POST /sapi/v1/staking/redeem`
  - `GET /sapi/v1/staking/position`
  - `GET /sapi/v1/staking/stakingRecord`
  - `POST /sapi/v1/staking/setAutoStaking`
  - `GET /sapi/v1/staking/personalLeftQuota`

- Deprecated BSwap endpoints:
  - `GET /sapi/v1/bswap/pools`
  - `GET /sapi/v1/bswap/liquidity`
  - `POST /sapi/v1/bswap/liquidityAdd`
  - `POST /sapi/v1/bswap/liquidityRemove`
  - `GET /sapi/v1/bswap/liquidityOps`
  - `GET /sapi/v1/bswap/quote`
  - `POST /sapi/v1/bswap/swap`
  - `GET /sapi/v1/bswap/swap`
  - `GET /sapi/v1/bswap/poolConfigure`
  - `GET /sapi/v1/bswap/addLiquidityPreview`
  - `GET /sapi/v1/bswap/removeLiquidityPreview`

## 1.4.0 - 2022-12-20
### Added
- Add RSA signature
- Support Ruby 3.1

### Changed
- Drop support of Ruby 2.5


## 1.3.0 - 2022-07-21

### Add
- New endpoint for Margin:
  - `POST /sapi/v3/asset/getUserAsset` to get user assets.
- New endpoint for Wallet:
  - `GET /sapi/v1/margin/dribblet` to query the historical information of user's margin account small-value asset conversion BNB.


## 1.2.0 - 2022-07-15

### Add
- Sub account endpoints
  - `POST /sapi/v1/sub-account/subAccountApi/ipRestriction` to support master account enable and disable IP restriction for a sub-account API Key
  - `POST /sapi/v1/sub-account/subAccountApi/ipRestriction/ipList` to support master account add IP list for a sub-account API Key
  - `GET /sapi/v1/account/apiRestrictions/ipRestriction` to support master account query IP restriction for a sub-account API Key
  - `DELETE /sapi/v1/account/apiRestrictions/ipRestriction/ipList` to support master account delete IP list for a sub-account API Key
- Market endpoint
  - `GET /api/v3/ticker`
- Trade endpoint
  - `POST /api/v3/order/cancelReplace`
- Websocket methods
  - `<symbol>@ticker_<window_size>`
  - `!ticker_<window-size>@arr`


## 1.1.0 - 2022-06-09

### Add
- Convert endpoint
  - `GET /sapi/v1/convert/tradeFlow`
- Margin Endpoint
  - `GET /sapi/v1/margin/crossMarginData`
  - `GET /sapi/v1/margin/isolatedMarginData`
  - `GET /sapi/v1/margin/isolatedMarginTier`
  - `GET /sapi/v1/margin/rateLimit/order`
 - All Staking Endpoints

### Update
- Fixing rubocop warnnings

## 1.0.3 - 2022-05-06
- Update rake version

## 1.0.2 - 2021-11-21

### Update
- Change README description and package settings

## 1.0.1 - 2021-11-21

### Update
- Change package name

## 1.0.0 - 2021-11-18

### Added
- First release
