import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import './HomePage.css'; // Assuming similar CSS styling rules as LoginPage.css
import { useNavigate } from 'react-router-dom'; // Import useNavigate for redirection

function HomePage() {
    const [userInfo, setUserInfo] = useState(null);
    const navigate = useNavigate(); // Hook for navigation
    
    useEffect(() => {
        // Fetch user info on component mount
        const fetchUserInfo = async () => {
            try {
                const response = await fetch('http://localhost:3001/get-user-info', {
                    method: 'GET',
                    credentials: 'include', // Necessary for cookies to be sent
                });
                const responseData = await response.json();
                if (responseData.status === 'success') {
                    setUserInfo(responseData.user);
                } else {
                    console.error('Failed to fetch user info');
                }
            } catch (error) {
                console.error('There was an error fetching user info!', error);
            }
        };

        fetchUserInfo();
    }, []);

    const handleLogout = async () => {
        try {
            const response = await fetch('http://localhost:3001/logout', { // Adjust URL as needed
                method: 'POST',
            });
            const responseData = await response.json();
            if (responseData.status === 'success') {
                // Optionally clear any client-side state here
                navigate('/login'); // Redirect to login page or wherever appropriate
            } else {
                console.error('Logout failed');
            }
        } catch (error) {
            console.error('There was an error!', error);
        }
    };

    const handleExamRegister = async () => {
        try {
            const response = await fetch('http://localhost:3001/exam-register', { // Adjust URL as needed
                method: 'POST',
                credentials: 'include'
                
            });
            const responseData = await response.json();
            if (responseData.status === 'success') {
                // Optionally clear any client-side state here
                navigate('/exam-register'); // Redirect to login page or wherever appropriate
            } else {
                console.error('Exam registration failed');
            }
        } catch (error) {
            console.error('There was an error!', error);
        }
    }

    const handleAnalytics = async () => {
        try {
            const response = await fetch('http://localhost:3001/analytics', { // Adjust URL as needed
                method: 'POST',
            });
            const responseData = await response.json();
            if (responseData.status === 'success') {
                // Optionally clear any client-side state here
                navigate('/analytics'); // Redirect to login page or wherever appropriate
            } else {
                console.error('Exam registration failed');
            }
        } catch (error) {
            console.error('There was an error!', error);
        }
    }

  return (
    <>
      <div className="navbar">
            <a href="#">Home</a>
            {/* Add more navigation items as needed */}
            <a onClick={handleLogout}>Logout</a> {/* Logout Button */}
          </div>
      <div className="header">
        {/* Display user information if available */}
        {userInfo && (
          <div>
            <h4>Welcome, {userInfo.name}</h4>
            {/* Display other user info as needed */}
          </div>
        )}
        </div>
      <div className="main-content">
        
        <section className="analytics-section">
          <h2>View Analytics</h2>
          <p>See your performance and areas to improve.</p>
          <button onClick={handleAnalytics}>Go to Analytics</button>
        </section>

        <section className="exam-section">
          <h2>Take Exam</h2>
          <p>Start or continue your exams here. Best of luck!</p>
          <button>Start Exam</button>
        </section>

        <section className="user-info-section">
          <h2>Exam Registration</h2>
          <button onClick={handleExamRegister}>Register Exam</button>
          <button>View Your Schedule</button>
          
        </section>
      </div>
    </>
  );
}

export default HomePage;
