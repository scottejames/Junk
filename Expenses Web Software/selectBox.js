		// Class Methods :
			
// Class method for passing option objects (Not needed in Netscape )
function becomes ( a, b ) {
	a.value = b.value;
	a.text = b.text;
	a.selected = b.selected;
	a.defaultSelected = b.defaultSelected;
}
	
// Class method for swapping option objects.
function swap ( a, b ) {
	var opt = new Option( a.text, a.value, a.defaultSelected, a.selected );
	becomes( a, b);
	becomes( b, opt);
}
		
		// Object Methods :
			
// Add an item to the SelectBox
function add(value, text) {
   	this.box.options[ this.box.options.length ] = new Option( text, value, false, true);
}

// Remove all selected items from the list.
function removeSelected() {
	var keptItems = new Array;
	var j = 0; // Counter for keptItems Index.

	// Record what we want
	for ( var i = 0; i < this.box.options.length; i++ )
		if ( this.box.options[i].selected == false)
			keptItems[j++] = new Option( this.box.options[i].text, this.box.options[i].value );
			
	this.box.options.length = keptItems.length;

	// Populate box with required elements
	for ( var i = 0; i < j; i++ )
		becomes( this.box.options[ i + this.lower ], keptItems[i] );
}

// Copy all the contents of a select box to another
function overWrite( to ) {
	to.length = this.box.options.length;

	for ( var i = 0; i < to.length; i++ )
		to[i] = new Option( this.box.options[i].text, this.box.options[i].value, false, true );

}

// Copy all selected items in the list.
function Selected() {
	var opt = new Array;
	
	for ( var i = this.lower; i < this.box.options.length; i++ )
		if ( this.box.options[i].selected == true)	
			opt[opt.length] = new Option( this.box.options[i].text, this.box.options[i].value, false, true );
		
	return opt;
}
	
// Copy selected items to another select box.
function copyTo ( to ) {
	var opt = this.Selected();
	for ( i = 0; i < opt.length; i++ ) to.add( opt[i].text, opt[i].value );
}
	
// Copy selected items from another select box.
function copyFrom ( from ) {
	from.copyTo( this );
}
	
// Gives all selected options from box to another box.
function give ( to ){
	this.copyTo( to );
	this.removeSelected();
}
	
// Takes all selected options from a box to another.
function take ( from ){
	from.give( this );
}
	
// Move all selected fields up the list.
function Up() {
	for( var i = this.lower + 1; i < ( this.box.options.length - this.upper ); i++ )
		if ( this.box.options[i].selected )		
			swap( this.box.options[i], this.box.options[i - 1] );
}
	
// Move all selected fields down the list.
function Down() {	
	for( var i = this.box.options.length -2; i >= this.lower; i--)
		if ( this.box.options[i].selected )
			swap( this.box.options[i], this.box.options[i + 1] );
}
	
// List all the contents of the selectBox.
function list( seperator ) {
	var listing = new Array;
	
	for ( i = 0; i < this.box.options.length; i++ )
		listing[ listing.length ] = this.box.options[i].text;

	return listing.join(seperator);
}
	
// Set the contents of a row.
function set( index, value, text){
	if ( isNaN(index) ) return 0;
	this.box.options[index] = new Option( text, value, false, true );
}

// Function initialiser.
function SelectBox ( box, lower, upper ) {

	// Properties
	this.box = box;				// The select box for the object.
	this.lower = isNaN(lower) ? 0 : lower;	// is first element of this list you can access.
	this.upper = isNaN(upper) ? 0 : upper;	// is the last element of the list you can access.
		
	// Pseudo-properties
	this.Selected = Selected;		// an array of selected elements.
	
	// Methods

		// Object alteration.
	this.add = add; 			// add an item to the box
	this.removeSelected = removeSelected;	// remove items from the box
	this.up = Up;				// Moves all selected elements up the select box
	this.down = Down;			// Moves all selected elements down the select box
	this.set = set;				// Alter a specific option referenced by index.
		
		// Object interaction.
	this.give = give;			// pass options to another box
	this.take = take;			// take options from another box
	this.copyTo = copyTo;			// it's like giving without the loss.
	this.copyFrom = copyFrom;		// it's like taking without the loss.
	this.overWrite = overWrite;		// Over write all from one box to another
		
		// To string 
	this.list = list;
}
