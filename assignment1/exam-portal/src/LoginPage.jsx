import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import './LoginPage.css';

function LoginPage() {
    const [formData, setFormData] = useState({
        email: '',
        password: '',
        role: 'student', // Default role; you might allow the user to select this
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
            const response = await fetch('http://localhost:3001/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                credentials: 'include',
                body: JSON.stringify(formData), // Pass the entire formData object, which includes the role
            });
    
            const responseData = await response.json();
            console.log(responseData);
    
            if (responseData.status === 'success') {
                console.log('Login successful:', responseData);
                // Navigate based on the role
                if (responseData.user.role === 'evaluator') {
                    navigate('/evaldashboard'); // Redirect evaluators to EvalDashboard
                } else {
                    navigate('/homepage'); // Redirect students and other roles to HomePage
                }
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
                <a href="/login">Home</a>
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
                        <div>
                            <label>Role:</label>
                            <select className='input-field' name="role" value={formData.role} onChange={handleChange} required>
                                <option value="student">Student</option>
                                <option value="evaluator">Evaluator</option>
                            </select>
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
