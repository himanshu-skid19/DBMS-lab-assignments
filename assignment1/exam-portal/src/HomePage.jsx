import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import './HomePage.css'; // Assuming similar CSS styling rules as LoginPage.css
import { useNavigate } from 'react-router-dom'; // Import useNavigate for redirection

function HomePage() {
    const [userInfo, setUserInfo] = useState(null);
    const navigate = useNavigate(); // Hook for navigation
    

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

  return (
    <>
      <div className="navbar">
            <a href="#">Home</a>
            {/* Add more navigation items as needed */}
            <button onClick={handleLogout}>Logout</button> {/* Logout Button */}
          </div>
      <div className="main-content">
        {/* Display user information if available */}
        {userInfo && (
          <div>
            <h2>Welcome, {userInfo.name}</h2>
            {/* Display other user info as needed */}
          </div>
        )}
        <section className="analytics-section">
          <h2>View Analytics</h2>
          <p>See your performance and areas to improve.</p>
          <Link to="/analytics">Go to Analytics</Link>
        </section>

        <section className="exam-section">
          <h2>Take Exam</h2>
          <p>Start or continue your exams here. Best of luck!</p>
          <button>Start Exam</button>
        </section>

        <section className="user-info-section">
          <h2>User Information</h2>
          <Link to="/userinfo">View User Information</Link>
        </section>
      </div>
    </>
  );
}

export default HomePage;
