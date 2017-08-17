let message = "Hello World!!";

var messages = {};
messages.welcome = "Hello Everyone";

function clicky() {
    alert("clicked");
}

ReactDOM.render(
    <div>
        <h1>{messages.welcome}</h1>
        <button onClick={clicky}>Click Me</button>
    </div>,
    document.getElementById('root')
);