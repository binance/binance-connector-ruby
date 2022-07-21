# Changelog

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
