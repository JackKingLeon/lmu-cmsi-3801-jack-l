import { open } from "node:fs/promises"
import { isUndefined } from "node:util"
import { createRequire } from 'module';
const require = createRequire(import.meta.url);

export function change(amount) {
  if (!Number.isInteger(amount)) {
    throw new TypeError("Amount must be an integer")
  }
  if (amount < 0) {
    throw new RangeError("Amount cannot be negative")
  }
  let [counts, remaining] = [{}, amount]
  for (const denomination of [25, 10, 5, 1]) {
    counts[denomination] = Math.floor(remaining / denomination)
    remaining %= denomination
  }
  return counts
}

// Write your first then lower case function here
export function firstThenLowerCase(strs, fxn){
    return strs.find(fxn)?.toLowerCase()
}

// Write your powers generator here
export function* powersGenerator(obj){
    let power = 0
    const {ofBase, upTo} = obj
    while (ofBase**power <= upTo){
        yield ofBase**power
        power++
    }
}

// Write your say function here
export function say(words){
    function inner(word){
        if (word == undefined){
            return words
        }
        return say(words.concat(" ", word))
    }

    if (words == undefined){
        return ""
    }
    return inner
}

// Write your line count function here
export function meaningfulLineCount(file){
    const fs = require('fs')

    const data = fs.readFileSync(file, "utf8")

    if (data == undefined){
        return undefined
    }

    const lines = data.split("\n")
    let returnedLines = []
    for (let line of lines){
        line = line.trim()
        if (line != undefined && line !== "" && line.substring(0,1) !== "#"){
            returnedLines.push(line)
        }
    }

    return returnedLines.length
}

// Write your Quaternion class here
export class Quaternion{
    constructor(a, b, c, d){
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        Object.freeze(this);
    }

    get coefficients(){
        return [this.a, this.b, this.c, this.d]
    }

    get conjugate(){
        return new Quaternion(this.a, -this.b, -this.c, -this.d)
    }

    plus(q){
        return new Quaternion(this.a + q.a, this.b + q.b, + this.c + q.c, this.d + q.d)
    }

    times(q){
        return new Quaternion(
            (this.a * q.a - this.b * q.b - this.c * q.c - this.d * q.d),
            (this.a * q.b + this.b * q.a + this.c * q.d - this.d * q.c),
            (this.a * q.c - this.b * q.d + this.c * q.a + this.d * q.b),
            (this.a * q.d + this.b * q.c - this.c * q.b + this.d * q.a)
        )
    }

    isPositive(num){
        return num > 0
    }

    toString(){
        let return_str = ""
        if (this.a === 0 && this.b === 0 && this.c === 0 && this.d === 0){
            return_str = "0"
        }

        if (this.a !== 0){
            return_str = this.a.toString()
        }
        
        if (this.b !== 0){
            if(this.isPositive(this.b)){
                return_str = return_str.concat("+")
            }
            return_str = return_str.concat(this.b.toString(), "i")
        }
        if (Math.abs(this.b) === 1){
            return_str = return_str.replace(/1/g, "")
        }

        if (this.c !== 0){
            if(this.isPositive(this.c)){
                return_str = return_str.concat("+")
            }
            return_str = return_str.concat(this.c.toString(), "j")
        }
        if (Math.abs(this.c) === 1){
            return_str = return_str.replace(/1/g, "")
        }

        if (this.d !== 0){
            if(this.isPositive(this.d)){
                return_str = return_str.concat("+")
            }
            return_str = return_str.concat(this.d.toString(), "k")
        }
        if (Math.abs(this.d) === 1){
            return_str = return_str.replace(/1/g, "")
        }
        
        if(return_str.substring(0,1) === "+"){
            return_str = return_str.substring(1)
        }

        return return_str
    }
}