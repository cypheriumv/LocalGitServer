from flask import Flask, render_template, request, redirect, url_for, flash
import os

app = Flask(__name__)
app.secret_key = 'supersecretkey'

# Load common passwords
with open('10-million-password-list-top-1000.txt', 'r') as file:
    common_passwords = set(file.read().splitlines())

# Function to check password requirements
def check_password_requirements(password):
    if len(password) < 10:  # Minimum 10 characters if no MFA
        return False
    if password in common_passwords:  # Block common passwords
        return False
    # Allow all printing ASCII characters including space
    if not all(32 <= ord(char) <= 126 for char in password):
        return False
    return True

@app.route('/', methods=['GET', 'POST'])
def home():
    if request.method == 'POST':
        password = request.form['password']
        if check_password_requirements(password):
            return redirect(url_for('welcome', password=password))
        else:
            flash('Password does not meet requirements.')
            return redirect(url_for('home'))
    return render_template('home.html')

@app.route('/welcome')
def welcome():
    password = request.args.get('password')
    return render_template('welcome.html', password=password)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
