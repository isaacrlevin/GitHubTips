import axios from 'axios';

// Vulnerable: Hardcoded API credentials
const API_KEY = 'placeholder_stripe_secret';
const SECRET_TOKEN = 'secret_abc123def456ghi789jkl012';
const GOOGLE_API_KEY = 'AIzaSyD1234567890abcdefghijklmnopqrs';

// Vulnerable: Using eval with user input
function executeUserCode(code) {
    return eval(code);
}

// Vulnerable: XSS vulnerability
function displayUserMessage(message) {
    document.getElementById('output').innerHTML = message;
}

// Vulnerable: Insecure random for security purposes
function generateToken() {
    return Math.random().toString(36).substring(2);
}

// Vulnerable: Local storage of sensitive data
function storeCredentials(username, password) {
    localStorage.setItem('username', username);
    localStorage.setItem('password', password);
    localStorage.setItem('apiKey', API_KEY);
}

// Vulnerable: Insecure HTTP request
async function loginUser(username, password) {
    const response = await axios.post('http://api.example.com/login', {
        username: username,
        password: password,
        apiKey: API_KEY
    });
    return response.data;
}

// Vulnerable: SQL injection in dynamic query building
function buildQuery(userId) {
    return `SELECT * FROM users WHERE id = ${userId}`;
}

// Vulnerable: Prototype pollution
function merge(target, source) {
    for (let key in source) {
        target[key] = source[key];
    }
    return target;
}

// Vulnerable: Unvalidated redirect
function redirectUser(url) {
    window.location.href = url;
}

// Vulnerable: Insecure CORS configuration
const corsConfig = {
    origin: '*',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH', 'OPTIONS']
};

// Hardcoded AWS credentials
const AWS_CONFIG = {
    accessKeyId: 'placeholder_aws_access_key',
    secretAccessKey: 'placeholder_aws_secret_access_key',
    region: 'us-east-1'
};

// Hardcoded database connection
const DB_CONNECTION = 'postgresql://admin:SuperSecretPass123@db.example.com:5432/mealplanner';

// Vulnerable: Using innerHTML with user content
function renderContent(userContent) {
    const container = document.createElement('div');
    container.innerHTML = userContent;
    document.body.appendChild(container);
}

// Vulnerable: Insecure cookie settings
function setCookie(name, value) {
    document.cookie = `${name}=${value}; SameSite=None`;
}

export {
    executeUserCode,
    displayUserMessage,
    generateToken,
    storeCredentials,
    loginUser,
    buildQuery,
    merge,
    redirectUser,
    corsConfig,
    AWS_CONFIG,
    DB_CONNECTION,
    renderContent,
    setCookie
};
