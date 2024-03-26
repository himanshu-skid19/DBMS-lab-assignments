// ScatterPlot.js
import React, { useRef, useEffect } from 'react';
import * as d3 from 'd3';

const ScatterPlot = ({ data }) => {
    const scatterRef = useRef();

    useEffect(() => {
        if (data && data.length) {
            d3.select(scatterRef.current).select("svg").remove();

            const margin = { top: 20, right: 20, bottom: 70, left: 60 },
                  width = 400 - margin.left - margin.right,
                  height = 280 - margin.top - margin.bottom;

            const svg = d3.select(scatterRef.current)
                .append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", `translate(${margin.left},${margin.top})`);

            // X axis for the average time taken
            const x = d3.scaleLinear()
                .domain([0, d3.max(data, d => d.average_time_taken/1000)])
                .range([0, width]);
            svg.append("g")
                .attr("transform", `translate(0,${height})`)
                .call(d3.axisBottom(x));

            // Y axis for the number of correct answers
            const y = d3.scaleLinear()
                .domain([0, d3.max(data, d => d.correct_answers)])
                .range([height, 0]);
            svg.append("g")
                .call(d3.axisLeft(y));

            svg.append("text")
                .attr("x", (width / 2))             
                .attr("y", 0 - (margin.top / 2))
                .attr("text-anchor", "middle")  
                .style("font-size", "16px") 
                .style("text-decoration", "underline")  
                .text("Number of Correct Answers vs Average Time Taken");

            // Add dots for each data point
            svg.selectAll("dot")
                .data(data)
                .enter()
                .append("circle")
                .attr("cx", d => x(d.average_time_taken/1000))
                .attr("cy", d => y(d.correct_answers))
                .attr("r", 5)
                .style("fill", "#69b3a2");
        }
    }, [data]);

    return <div ref={scatterRef} />;
};

export default ScatterPlot;
