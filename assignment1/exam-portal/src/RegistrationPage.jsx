import { useState } from 'react';
import { Link } from 'react-router-dom';
import './RegistrationPage.css';
import { useNavigate } from 'react-router-dom'; // Import useNavigate for redirection

function RegistrationPage() {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    confirmPassword: '',
    name: '',
    role: '',
    studentID: '',
    phone: '',
    evaluatorID: '',
    evaluatorPhone: '',
  });
  const navigate = useNavigate(); // Hook for navigation
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevState => ({
      ...prevState,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
  
    if (formData.password !== formData.confirmPassword) {
        alert('Passwords do not match');
        return;
    }

    // Assuming you're correcting the form data handling as per your application's needs

    try {
        const response = await fetch('http://localhost:3001/register', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              name: formData.name,
              email: formData.email,
              password: formData.password,
              role: formData.role,
                studentID: formData.studentID,
                phone: formData.phone,
            }),
          });
  
      const responseData = await response.json(); // Assuming the response is JSON
      console.log(responseData);
    } catch (error) {
      console.error('There was an error!', error);
    }

    try {
        const response = await fetch('http://localhost:3001/register2', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              name: formData.name,
              role: formData.role,
                studentID: formData.studentID,
                phone: formData.phone,
              
            }),
          });
  
      const responseData = await response.json(); // Assuming the response is JSON
      console.log(responseData);
      if (responseData.status === 'success') {
        // Optionally clear any client-side state here
        navigate('/login'); // Redirect to login page or wherever appropriate
    } else {
        console.error('Registration failed');
    }
    } catch (error) {
      console.error('There was an error!', error);
    }
    
  };



  return (
    <>
      <div className="navbar">
          <a href="#home">Home</a>
          {/* Additional navigation items here */}
      </div>
      <div className='main-content'>
        <div className="registration-container">
          <h2 className='head'>Exam Portal Registration</h2>
          <form onSubmit={handleSubmit} className="registration-form">
            <div className='form-columns'>
              <div className='left-column'>
                {/* Left column fields */}
                <div className="form-group">
                  <label htmlFor="name">Name:</label>
                  <input className="input-field" type="text" id="name" name="name" value={formData.name} onChange={handleChange} required />
                </div>
                <div className="form-group">
                  <label htmlFor="email">Email:</label>
                  <input className="input-field" type="email" id="email" name="email" value={formData.email} onChange={handleChange} required />
                </div>
                <div className="form-group">
                  <label htmlFor="password">Password:</label>
                  <input className="input-field" type="password" id="password" name="password" value={formData.password} onChange={handleChange} required />
                </div>
                <div className="form-group">
                  <label htmlFor="confirmPassword">Confirm Password:</label>
                  <input className="input-field" type="password" id="confirmPassword" name="confirmPassword" value={formData.confirmPassword} onChange={handleChange} required />
                </div>
                <div className="form-group">
                  <label htmlFor="role">Role:</label>
                  <select className="input-field2" id="role" name="role" value={formData.role} onChange={handleChange} required>
                    <option value="">Select a role</option>
                    <option value="student">Student</option>
                    <option value="evaluator">Evaluator</option>
                  </select>
                </div>
              </div>
  
              {/* Conditional fields for "Student" */}
              {formData.role === 'student' && (
                <div className='middle-column'>
                  <div className="form-group">
                    <label htmlFor="student-id">Student ID:</label>
                    <input className="input-field" type="text" id="student-id" name="studentID" value={formData.studentID} onChange={handleChange} required />
                  </div>
                  <div className="form-group">
                    <label htmlFor="phone">Phone:</label>
                    <input className="input-field" type="text" id="phone" name="phone" value={formData.phone} onChange={handleChange} required />
                  </div>
                </div>
              )}
              {formData.role === 'evaluator' && (
                <div className='middle-column'>
                  <div className="form-group">
                    <label htmlFor="evaluator-id">Evaluator ID:</label>
                    <input className="input-field" type="text" id="evaluator-id" name="evaluatorID" value={formData.evaluatorID} onChange={handleChange} required />
                  </div>
                  <div className="form-group">
                    <label htmlFor="phone">Phone:</label>
                    <input className="input-field" type="text" id="phone" name="phone" value={formData.evaluatorPhonehone} onChange={handleChange} required />
                  </div>
                </div>
              )}
              
            </div>
  
            <button type="submit" className="submit-button">Register</button>
            <Link to="/" className="login-link">Already have an account? Log In</Link>
          </form>
        </div>
      </div>
    </>
  );
}

export default RegistrationPage;
