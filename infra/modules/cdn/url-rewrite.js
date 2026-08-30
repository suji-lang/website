function handler(event) {
  var request = event.request;
  var uri = request.uri;

  if (uri === "/book") {
    return {
      statusCode: 301,
      statusDescription: "Moved Permanently",
      headers: {
        location: { value: "/book/" }
      }
    };
  }

  if (uri.charAt(uri.length - 1) === "/") {
    request.uri = uri + "index.html";
  }

  return request;
}
