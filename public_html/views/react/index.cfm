    <script src="https://unpkg.com/react@latest/dist/react.min.js"></script>
    <script src="https://unpkg.com/react-dom@latest/dist/react-dom.min.js"></script>
    <script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>

    <div id="root"></div>

    <script type="text/babel">

        let message = "Hello World!!";

        var messages = {};
        messages.welcome = "Hello Everyone";

        function clicky(){
            alert("clicked");
        }

      ReactDOM.render(
        <div>
        <h1>{messages.welcome}</h1>
        <button onClick={clicky}>Click Me</button>
        </div>,
        document.getElementById('root')
      );

    </script>
