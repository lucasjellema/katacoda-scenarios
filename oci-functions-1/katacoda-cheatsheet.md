https://katacoda.com/scenario-examples

Source code: https://github.com/katacoda/scenario-examples/


https://katacoda.com/scenario-examples/scenarios/markdown-extensions

This can also be helped by using Keyboard symbols to show users to use +

The Markdown is:

<kbd>Ctrl</kbd>+<kbd>C</kbd>

Mulit-Line Execute in Terminal
The same functionality as above is available over multiple lines.

```
echo "Line 1"

echo "Line 2"

echo "Line 3"
```{{execute}}

Copy to Clipboard
This extension will copy the command or text to the clipboard.

Markdown:

`echo "Copy to Clipboard"`{{copy}}
Results: echo "Copy to Clipboard"

Multi-Line Copy to Clipboard
The same functionality as above is available over multiple lines.

Markdown:

```
echo "Line 1"

echo "Line 2"

echo "Line 3"
```{{copy}}

Katacoda supports copying code snippets or longer text into the clipboard by adding the attribute data-target.

Copy to ClipboardCopy Me To The Clipboard!!
This is created by embedded HTML into the Markdown.

<pre class="file" data-target="clipboard">
Copy Me To The Clipboard!!
</pre>

Copy snippets into file in editor:
<pre class="file" data-filename="func.js" data-target="append">



Check if step has been performed:
"verify": "step1-verify.sh"

https://katacoda.com/scenario-examples/scenarios/verified-steps



To provide users with more information or context, a Answer section can be provided.

Here is the snippet from Step 2 within the index.json.

"details": {
    "steps": [
        {
            "title": "Step 2 - Show Answers",
            "text": "step2.md",
            "answer": "step2-answer.md"
        }
    ]
}


Display progress indicator:

https://github.com/katacoda/scenario-examples/tree/master/displaying-progress-spinner

