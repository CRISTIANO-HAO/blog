export const getTimeUtil = (timeStamp, format) => {
  if (!timeStamp) {
    return;
  }
  let date = new Date(timeStamp);
  let obj = {
    yyyy: date.getFullYear() + "",
    MM: date.getMonth() + 1 >= 10 ? date.getMonth() + 1 : "0" + (date.getMonth() + 1),
    dd: date.getDate() >= 10 ? date.getDate() : "0" + date.getDate(),
    HH: date.getHours() >= 10 ? date.getHours() : "0" + date.getHours(),
    mm: date.getMinutes() >= 10 ? date.getMinutes() : "0" + date.getMinutes(),
    ss: date.getSeconds() >= 10 ? date.getSeconds() : "0" + date.getSeconds()
  }
  if (format) {
    for(let key in obj){
      if (key === "yyyy"){
        format = format.replace(/y+/, (str) => {
          return obj["yyyy"].slice(4 - str.length);
        });
      }else {
        format = format.replace(new RegExp(key),obj[key])
      }
    }
    return format;
  } else {
    return obj["yyyy"] + "-" + obj["MM"] + "-" + obj["dd"];
  }
}
