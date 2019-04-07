const baseHost = "http://localhost:3000/"



function fetchSlots() {
  const slotCount = document.getElementById("slot-number").value
  this.buildRequest(slotCount)
}

function appendResponse(res) {
  let availabilities = document.getElementById("availabilities")
  availabilities.innerHTML = ""
  res.forEach(item => {
    this.appendRow(availabilities, item)
  })

}

function appendRow(availabilities, item) {
  let div = document.createElement('div');
    div.className = 'row';
    div.innerHTML = `<div> \
      <p> ID: ${item.id} </p>\
      <p> Start Time: ${this.displayDateTime(item.start_time)}</p>\
      <p> End Time: ${this.displayDateTime(item.end_time)}</p>\
      <label> <input type="checkbox" name="check" value="1" /> Select </label>\
    `
    availabilities.appendChild(div);
}

function displayDateTime(timeStamp) {
  return new Date(timeStamp).toLocaleString()
}

function buildRequest(slotCount) {

  try {
    const data = apiGet(`slots/candidate_schedules?slot[count]=${slotCount}`);
    data.then(res => {
      this.appendResponse(res)
    });
  } catch (err) {
    console.log(err);
  }

}

// API FUNCTIONS //
async function makeRequest(path, options) {

  let newPath = `${baseHost}${path}`
  const response = await fetch(newPath, options)
  const json = response.json()

  if (response.ok) {
    return Promise.resolve(json)
  } else {
    throw new Error(json.message || response.statusText)
  }
  
}


function apiGet(path, options) {
  return makeRequest(path, buildOptions(options))
}


function buildOptions(options = {}) {
  const requestOptions = {
    method: options.method || "GET",
    headers: {
      "Accept": "application/json"
    }
  }

  if (options.body) {
    requestOptions.body = JSON.stringify(options.body)
  }

  return requestOptions
}

