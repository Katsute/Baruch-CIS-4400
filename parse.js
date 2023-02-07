const fs = require("fs");
const rl = require("readline");

async function main(){
    const OUT = {
        "HEAT/HOT WATER": null,
        "Water System": null,
        "Sewer": null,
        "PLUMBING": null,
        "General Construction/Plumbing": null,
        "WATER LEAK": null,
        "Root/Sewer/Sidewalk Condition": null,
        "Water Conservation": null,
        "Drinking": null,
        "Plumbing": null,
        "Water Quality": null,
        "Standing Water": null,
        "Indoor Sewage": null,
        "Drinking Water": null,
        "Bottled Water": null,
    };

    for(const k in OUT){
        OUT[k] = fs.createWriteStream(`${k.replace(/ |\//g, '-').toLowerCase()}.csv`);
    }

    let x = 0, w = 0;
    for await (const ln of rl.createInterface({ input: fs.createReadStream("311.csv"), crlfDelay: Infinity})){
        const col = ln.split(',');
        if(x++ == 0) // write header
            for(const k in OUT)
                OUT[k].write(ln + '\n');
        else{
            const match = col[5];
            for(const k in OUT){
                if(match === k){
                    OUT[k].write(ln + '\n');
                    console.log(`${++w}/${x}`);
                }
            }
        }
    }

    for(const k in OUT)
        OUT[k].end();
}

main();