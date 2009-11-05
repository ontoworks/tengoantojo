describe "jQuery ajax calls in Firefox fail"
  it "should do an Ajax call in Firefox and fail"
    $.get("http://localhost:4567/hola_mundo", function(text) {
      text.should_not.include "hola"
    })
  end
end
