const fs = require("fs");
const rl = require("readline");

async function main(){
    const OUT = {};

    let x = 0;
    let header;
    // read stream
    for await (const ln of rl.createInterface({ input: fs.createReadStream("311.csv"), crlfDelay: Infinity})){
        const col = ln.split(',');
        if(x++ == 0) // header
            header = ln;
        else{
            const k = col[5].replace(/ |\//g, '-').toLowerCase();
            if(!OUT[k]){ // new file
                OUT[k] = fs.createWriteStream(`${k}.csv`);
                OUT[k].write(header);
            }
            OUT[k].write('\n' + ln); // append
            console.log(x);
        }
    }

    // close
    for(const k in OUT)
        OUT[k].end();
}

main();