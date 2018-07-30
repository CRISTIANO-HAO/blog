export default ({type = "GET",method = "", url = "", data = {}, async = true} = {}) => {
  return new Promise((resolve, reject) => {
    if (method !== ""){
      type = method;
    }
    type = type.toUpperCase();
    let XMLObj;
    if (window.XMLHttpRequest) {
      XMLObj = new XMLHttpRequest();
    } else {
      XMLObj = new ActiveXObject();
    }

    if (type === "GET") {
      let dataStr = "";
      Object.keys(data).forEach((key, index) => {
        dataStr += key + "=" + data[key] + "&";
      });
      dataStr = dataStr.slice(0, dataStr.lastIndexOf("&"));
      if (dataStr !== ""){
        url = url + "?" + dataStr;
      }

      XMLObj.open(type, url, async);
      XMLObj.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      XMLObj.send();
    } else if (type === "POST") {
      XMLObj.open(type, url, async);
      //XMLObj.setRequestHeader("Content-type", "application/json");
      XMLObj.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      let dataStr = "";
      Object.keys(data).forEach((key, index) => {
        dataStr += key + "=" + data[key] + "&";
      });
      dataStr = dataStr.slice(0, dataStr.lastIndexOf("&"));
      XMLObj.send(dataStr);
    } else {
      reject("type is error")
    }

    XMLObj.onreadystatechange = () => {
      if (XMLObj.readyState === 4 ){
        if (XMLObj.status === 200){
          let response = XMLObj.response;
          if (typeof response !== "object"){
            response = JSON.parse(response);
          }
          resolve(response);
        }else {
          reject(XMLObj);
        }
      }
    }
  });
}
