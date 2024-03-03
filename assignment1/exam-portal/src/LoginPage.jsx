import { useState } from 'react';
import './LoginPage.css';
import { Link, useNavigate } from 'react-router-dom';

function LoginPage() {
    const [formData, setFormData] = useState({
        email: '',
        password: ''
    });

    const navigate = useNavigate();

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const response = await fetch('http://localhost:3001/login', { // Updated to match your Express server port and endpoint
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json', // Ensure we're sending JSON
                },
                body: JSON.stringify({
                    email: formData.email,
                    password: formData.password,
                }),
            });

            const responseData = await response.json(); // Parse JSON response
            console.log(responseData);

            if (responseData.status === 'success') {
                console.log('Login successful:', responseData);
                navigate('/homepage'); // Navigate to homepage on successful login
            } else {
                alert('Login failed: ' + responseData.message);
            }

        } catch (error) {
            console.error('Login error:', error);
            alert('An error occurred during login. Please try again.');
        }
    };

    return (
        <>
            <div className="navbar">
                <a href="#">Home</a>
                {/* Add more navigation items as needed */}
            </div>
            <div className="main-content">
                <div className="login-container">
                    <h2 className='head'>Examination Portal Login</h2>
                    <form onSubmit={handleSubmit}>
                        <div>
                            <label>Email:</label>
                            <input className="normaltext" type="email" name="email" value={formData.email} onChange={handleChange} required />
                        </div>
                        <div>
                            <label>Password:</label>
                            <input className='normaltext' type="password" name="password" value={formData.password} onChange={handleChange} required />
                        </div>
                        <button type="submit">Login</button>
                    </form>

                    <Link to="/register">Don't have an account? Sign up</Link>
                </div>
            </div>
        </>
    );
}

export default LoginPage;
