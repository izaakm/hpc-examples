#!/usr/bin/env python

'''
How to use a console with a python file in Jupyter (Open OnDemand)

1. Create a Jupyter session in Open OnDemand
2. Once you start your Jupyter notebook, click "View" > "Open JupyterLab"
3. Open the `.py` file you want to edit
4. Then, click "File" > "Create Console for Editor"
5. In the console, use either `%run <filename>` or `import <filename>` to load the contents of your script
'''

name = 'World'

if __name__ == '__main__':
    print('Hello,', name)