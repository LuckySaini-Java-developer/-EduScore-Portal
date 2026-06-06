const marksInputs = document.querySelectorAll('input[type="number"]');
marksInputs.forEach(input => {
        input.addEventListener('input', function() {
			if (this.id === 'rollno') {
			    return; 
			}
                if (this.value > 100) {
            alert("Error: Marks cannot be greater than 100!"); 
            this.value = ""; 
        }
                if (this.value < 0) {
            alert("Error: Marks cannot be negative!");
            this.value = ""; 
        }
    });
});
