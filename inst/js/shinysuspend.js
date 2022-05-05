(function() {
    // Manage suspended inputs
    var suspendedInputs = new Set();

    function isInputSuspended(id) {
        return suspendedInputs.has(id);
    }

    function suspendInput(id) {
        suspendedInputs.add(id);
    }

    function resumeInput(id) {
        suspendedInputs.delete(id);
        Shiny.forgetLastInputValue(id);
    }

    // Prevent changes to suspended inputs
    $(document).on("shiny:inputchanged", function(event) {
        isInputSuspended(event.name) && event.preventDefault();
    });    

    // Handle commands from R session
    Shiny.addCustomMessageHandler(
        "shinysuspend:suspendinput",
        function(message) {
            suspendInput(message.id);
        }
    );
        
    Shiny.addCustomMessageHandler(
        "shinysuspend:resumeinput",
        function(message) {
            resumeInput(message.id);
        }
    );
})();
