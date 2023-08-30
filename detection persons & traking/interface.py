import tkinter as tk
import draw_traking


root = tk.Tk()
root.title("Button Example")
root.geometry("500x500")  
my_font=('times', 8, 'bold')
def on_click():
    draw_traking.Video.mainVideo



button = tk.Button(root, text='Hi  Welcome',commad=on_click)
button.pack()


root.mainloop()


