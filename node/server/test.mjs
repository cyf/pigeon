// import sortKeysRecursive from 'sort-keys-recursive'
// import queryString from 'query-string'
import CryptoJS from 'crypto-js'
import bcrypt from "bcrypt";

// console.log(sortKeysRecursive({ a: 1, c: 3, b: 2 }), queryString.stringify(sortKeysRecursive({ a: 1, c: 3, b: 2 })))
// console.log(sortKeysRecursive({ a: { b1: 2, a1: 1 }, c: 3, b: 2 }), queryString.stringify(sortKeysRecursive({ a: { b1: 2, a1: 1 }, c: 3, b: 2 })))
// console.log(sortKeysRecursive({ a: { b1: 2, a1: [3, 2, 1] }, c: 3, b: 2 }), queryString.stringify(sortKeysRecursive({ a: { b1: 2, a1: [3, 2, 1] }, c: 3, b: 2 })))
// console.log(sortKeysRecursive({ a: [3, 2, 1], c: 3, b: 2 }), queryString.stringify(sortKeysRecursive({ a: [3, 2, 1], c: 3, b: 2 })))

// const queryStr = queryString.stringify(sortKeysRecursive({
//   nonce: '6ec0bd7f-11c0-43da-975e-2a8ad9ebae0b',
//   timestamp: '1705236610223',
//   a: [ '1', '2', '3' ],
//   b: '2',
//   c: '3'
// }))
// console.log(queryStr)
// const utf8Str = CryptoJS.enc.Utf8.parse(
//   queryStr + '<your sign key>',
// )
// const sign = CryptoJS.enc.Hex.stringify(CryptoJS.MD5(utf8Str))
// console.log(sign)

const key = CryptoJS.enc.Utf8.parse('weufhweuykhfuweh')
const iv = CryptoJS.enc.Utf8.parse('euyafgduywegfkuy')

// export const encrypt = (text) => {
//   const encrypted = CryptoJS.AES.encrypt(text, key, {
//     iv: iv,
//     padding: CryptoJS.pad.Pkcs7,
//     mode: CryptoJS.mode.CBC,
//     hasher: CryptoJS.algo.SHA256
//   });
//
//   return encrypted.toString();
// };
//
// export const decrypt = (encrypted) => {
//   const decrypted = CryptoJS.AES.decrypt(encrypted, key, {
//     iv: iv,
//     padding: CryptoJS.pad.Pkcs7,
//     mode: CryptoJS.mode.CBC,
//     hasher: CryptoJS.algo.SHA256
//   })
//   return decrypted.toString(CryptoJS.enc.Utf8);
// };

export const encrypt = (text) => {
  return CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(text), key, {
    mode: CryptoJS.mode.CTR,
    iv: iv,
  }).toString()
}

export const hashed = (text) => {
  return bcrypt.hashSync(text, 10)
}

const encrypted = encrypt('12345678')
console.log(encrypted)
const hashedText = hashed(encrypted)
console.log(hashedText)
