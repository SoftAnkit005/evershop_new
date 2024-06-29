import React from 'react';

export default function FeaturedNewProducts() {
  const collection = {
    problems: [
      { "alt": "Black Onyx", "url": "Assets/Images/problem1.png" },
      { "alt": "Black Onyx", "url": "Assets/Images/problem2.png" },
      { "alt": "Black Onyx", "url": "Assets/Images/problem3.png" }
    ],
    solutions: [
      { "alt": "Black Onyx", "url": "Assets/Images/solution1.png" },
      { "alt": "Black Onyx", "url": "Assets/Images/solution2.png" },
      { "alt": "Black Onyx", "url": "Assets/Images/solution3.png" }
    ]
  }

  return (
    <div className="bg-theme-gray problems-section">
      <div className="products col-11 col-xxl-8 col-md-10 m-auto">
        <div className="problems-list">
          <h3 className="fae-head">
            <span>We Understand How It Feels To Have </span>
            These Problems.
          </h3>

          <div className='row'>
            {collection.problems.map((item) =>
              <div className='col-md-4 p-4 col-sm-12'>
                <img src={item.url} className='rounded-4' alt={item.alt} />
              </div>
            )}
          </div>
          <div className="problems-list">
            <h3 className="fae-head">
              <span>We are here to provide </span>
              you a solution.
            </h3>

            <div className='row'>
              {collection.solutions.map((item) =>
                <div className='col-md-4 p-4 col-sm-12'>
                  <img src={item.url} className='rounded-4' alt={item.alt} />
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export const layout = {
  areaId: 'content',
  sortOrder: 11
};
