Loan Management App

This iOS application provides a list and detailed view of loan information, including borrower details, loan amount, interest rate, term, purpose, risk rating, and associated documents. The application also allows users to fetch and view loan-related documents, and provides the ability to zoom into document images.

Features:
- Fetch Loan data from API
- Display loan details
- Zoom the image of income statement by tapping the image and view it in the larger size using a new sheet

Installation:
git clone https://github.com/zakkimdfr/SamirAssignment.git

Requirements:
- iOS 17.5
- Xcode 15.0

Dependencies:
- URLSession: to fetch document data from URL.
- UIImage: to display document image.

Architecture:
The app follows the MVVM (Model-View-ViewModel) architecture pattern to ensure a clean separation of concerns and promote testability and maintainability.

Screenshot:
<img src="https://github.com/zakkimdfr/SamirAssignment/assets/28290737/f2b450dc-85fd-471c-90d7-651eb8f640b5" width="300">
<img src="https://github.com/zakkimdfr/SamirAssignment/assets/28290737/40a13ca6-9450-4276-98f2-36b1ab7f97bc" width="300">
<img src="https://github.com/zakkimdfr/SamirAssignment/assets/28290737/f3c030a9-5322-4dc9-be95-33270c86fc44" width="300">
