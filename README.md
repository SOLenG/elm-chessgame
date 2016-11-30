Docker for use a sandbox elm
----------------------------

Add in your `./bash_aliases`

```bash
alias elm='docker run -it --rm -v "$(pwd):/code" -w "/code" -e "HOME=/tmp" -u $UID:$GID -p 8000:8000 codesimple/elm:0.18'
```

```cmd
elm make
elm package
elm reactor -a 0.0.0.0
elm repl
elm test
```

(You will usually need to use the -a 0.0.0.0 option when running elm reactor so that you can access it from outside of the container).

Run the application
-------------------

Install the project elm packages
```cmd
elm package install
```

Run the server elm

```cmd
elm reactor - a 0.0.0.0
```

Access at the app in your browser by : http://localhost:8000/

