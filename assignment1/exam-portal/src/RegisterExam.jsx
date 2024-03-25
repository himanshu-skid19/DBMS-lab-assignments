import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import './RegisterExam.css'; // Ensure this CSS file includes the two-column layout CSS

function RegisterExam() {
    const [examDetails, setExamDetails] = useState({
        examID: '',
        examName: '',
        fees: '',
        date: '',
        timeslot: '',
        venue: '',
        did: ''
    });
    const navigate = useNavigate();

    const handleChange = (e) => {
        const { name, value } = e.target;
        setExamDetails(prevDetails => ({
            ...prevDetails,
            [name]: value
        }));
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            const response = await axios.post('http://localhost:3001/register-exam', examDetails, { withCredentials: true });
            if (response.data.status === 'success') {
                alert('Exam registered successfully');
                navigate('/evaldashboard'); // Redirect to homepage or another relevant page
            } else {
                alert('Exam registration failed: ' + response.data.message);
            }
        } catch (error) {
            console.error('Registration error:', error);
            alert('An error occurred during exam registration. Please try again.');
        }
    };

    return (
        <>
        <div className="navbar">
        <a href="/homepage">Home</a>
        {/* Additional navigation items here */}
      </div>
        <div className="register-exam-container">
            <h2>Register an Exam</h2>
            <form onSubmit={handleSubmit} className="exam-registration-form">
                <div className='form-columns'>
                    <div className='left-column'>
                    <div className="form-group">
                        <label htmlFor="examID">Exam ID:</label>
                        <input type="text" id="examID" name="examID" value={examDetails.examID} onChange={handleChange} required />

                        <label htmlFor="examName">Exam Name:</label>
                        <input type="text" id="examName" name="examName" value={examDetails.examName} onChange={handleChange} required />

                        <label htmlFor="fees">Fees:</label>
                        <input type="number" id="fees" name="fees" value={examDetails.fees} onChange={handleChange} required />
                    </div>
                    </div>

                    <div className="middle-column">
                    <div className="form-group">
                    <label htmlFor="date">Date:</label>
                        <input type="date" id="date" name="date" value={examDetails.date} onChange={handleChange} required />
                    </div>
                    <div className="form-group">
                        <label htmlFor="timeslot">Timeslot:</label>
                        <input type="text" id="timeslot" name="timeslot" value={examDetails.timeslot} onChange={handleChange} required />
                    </div>
                    <div className="form-group">
                        <label htmlFor="venue">Venue:</label>
                        <input type="text" id="venue" name="venue" value={examDetails.venue} onChange={handleChange} required />
                    </div>
                    <div className="form-group">
                        <label htmlFor="did">Did:</label>
                        <input type="text" id="did" name="did" value={examDetails.did} onChange={handleChange} required />
                    </div>
                    </div>
                </div>
                
                <button type="submit" className="register-btn">Register Exam</button>
            </form>
        </div>
        </>
        
    );
}

export default RegisterExam;
