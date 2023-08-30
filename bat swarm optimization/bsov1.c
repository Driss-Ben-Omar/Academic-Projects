#include<stdio.h>
#include<stdlib.h>
#include <math.h>
#include <time.h>

#define PI 3.14159265358979323846

// Structure to represent a city
typedef struct {
  double x;
  double y;
} City;

// Structure to represent a bat
typedef struct {
  double *solution;
  double fitness;
  double frequency;
  double loudness;
  double pulse_rate;
} Bat;

// Function prototypes

// Function objective 
double calculate_distance(double *solution, City *cities, int num_cities);

void initialize_bats(Bat *bats, int num_bats,City * cities, int num_cities);
void update_frequencies(Bat *bats, int num_bats);
void update_loudness(Bat *bats, int num_bats);
void update_pulse_rate(Bat *bats, int num_bats);
void search(Bat *bats, int num_bats, City *cities, int num_cities);
void copy_solution(double *dest, double *src, int num_cities);
int is_new_best_solution(Bat *bats, int num_bats, double *best_solution, double *best_fitness,int *best_num_bat);
void shuffle(double *array, int num_elements);

int main(int argc, char *argv[]) {
 // srand(time(NULL));

  // Read the number of cities from the command line
  int num_cities = 52;  // atoi(argv[1]);

  // Read the cities from stdin
  City cities[52]= {
    {565.0,575.0},
    {25.0,185.0},
    {345.0, 750.0},
    {945.0, 685.0},
    {845.0, 655.0},
    {880.0 ,660.0},
    {25.0, 230.0},
    {525.0, 1000.0},
    {580.0 ,1175.0},
    {650.0, 1130.0},
    {1605.0 ,620.0 },
    {1220.0, 580.0},
    {1465.0, 200.0},
    {1530.0, 5.0},
    {845.0, 680.0},
    {725.0, 370.0},
    {145.0, 665.0},
    {415.0, 635.0},
    {510.0, 875.0},  
    {560.0,365.0},
    {300.0, 465.0},
    {520.0 ,585.0},
    {480.0, 415.0},
    {835.0, 625.0},
    {975.0 ,580.0},
    {1215.0, 245.0},
    {1320.0 ,315.0},
    {1250.0 ,400.0},
    {660.0, 180.0},
    {410.0, 250.0},
    {420.0, 555.0},
    {575.0, 665.0},
    {1150.0, 1160.0},
    {700.0, 580.0},
    {685.0, 595.0},
    {685.0, 610.0},
    {770.0, 610.0},
    {795.0, 645.0},
    {720.0, 635.0},
    {760.0, 650.0},
    {475.0, 960.0},
    {95.0 ,260.0},
    {875.0, 920.0},
    {700.0, 500.0},
    {555.0, 815.0},
    {830.0, 485.0},
    {1170.0, 65.0},
    {830.0, 610.0},
    {605.0, 625.0},
    {595.0, 360.0},
    {1340.0, 725.0},
    {1740.0, 245.0},} ;


  // Set the number of bats
  int num_bats = 100;

  // Set the maximum number of iterations
  int max_iterations = 10000;

  // Initialize the bats
  Bat bats[num_bats];

  initialize_bats(bats, num_bats,cities, num_cities);

  // Set the best solution to the solution of the first bat
  double best_fitness = bats[0].fitness;
  int best_num_bat =0;
  double *best_solution = malloc(num_cities * sizeof(double));

  copy_solution(best_solution, bats[0].solution, num_cities);

  // Iterate for a maximum number of iterations
  int i;
  for (i = 0; i < max_iterations; i++) {
    // Update the frequency and loudness of each bat
    update_frequencies(bats, num_bats);
    update_loudness(bats, num_bats);
        // Let the bats search for new solutions
    search(bats, num_bats, cities, num_cities);

    // Update the pulse rate of each bat
    update_pulse_rate(bats, num_bats);

    // Check if any of the new solutions is the best solution so far
    if (is_new_best_solution(bats, num_bats, best_solution, &best_fitness,&best_num_bat)) {
      // If a new best solution is found, copy it to best_solution
      copy_solution(best_solution, bats[best_num_bat].solution, num_cities);
    }
  }

  // Print the best solution
  for (i = 0; i < num_cities; i++) {
    printf("%d ->", (int)best_solution[i]);
  }
  printf("\n");
//double calculate_distance(double *solution, City *cities, int num_cities);

  printf("\n la distance is %f",calculate_distance(best_solution,cities,num_cities));

  // Free the memory allocated for the best solution
  free(best_solution);

  return 0;
}


void initialize_bats(Bat *bats, int num_bats,City * cities, int num_cities) {
	int i,j;
  for (i = 0; i < num_bats; i++) {
    // Allocate memory for the solution array
    bats[i].solution = malloc(num_cities * sizeof(double));
    // Generate a random solution
    for (j = 0; j < num_cities; j++) {
      bats[i].solution[j] = j;
    }
    shuffle(bats[i].solution, num_cities);

    // Calculate the fitness of the solution
    bats[i].fitness = calculate_distance(bats[i].solution, cities, num_cities);

    // Set the initial frequency and loudness
    bats[i].frequency = 0;
    bats[i].loudness = 0;

    // Set the initial pulse rate
    bats[i].pulse_rate = 0;
  }
}


// Update the frequency and loudness of each bat
void update_frequencies(Bat *bats, int num_bats) {
  double fmin = 0;
  double fmax = 200000;
  int i;
  for (i = 0; i < num_bats; i++) {
    bats[i].frequency = fmin + (fmax - fmin) * rand() / RAND_MAX;
  }
}

void update_loudness(Bat *bats, int num_bats) {
  double lmin = 0;
  double lmax = 1;
  int i;
  for (i = 0; i < num_bats; i++) {
    bats[i].loudness = lmin + (lmax - lmin) * rand() / RAND_MAX;
  }
}

// Update the pulse rate of each bat
void update_pulse_rate(Bat *bats, int num_bats) {
  double rmin = 0;
  double rmax = 1;
  int i;
  for (i = 0; i < num_bats; i++) {
    bats[i].pulse_rate = rmin + (rmax - rmin) * rand() / RAND_MAX;
  }
}

// Let the bats search for new solutions
void search(Bat *bats, int num_bats, City *cities, int num_cities) {
	int i;
  for (i = 0; i < num_bats; i++) {
    double f = bats[i].frequency;
    double l = bats[i].loudness;
    double r = bats[i].pulse_rate;
    double *s = bats[i].solution;
    // Generate a new solution

    double *new_solution = malloc(num_cities * sizeof(double));
    copy_solution(new_solution, s, num_cities);

    int j = rand() % num_cities;
    int k = rand() % num_cities;
    int temp = new_solution[j];
    new_solution[j] = new_solution[k];
    new_solution[k] = temp;

    // Calculate the fitness of the new solution
    double new_fitness = calculate_distance(new_solution, cities, num_cities);

    // Accept the new solution with probability e^(-l*|f_new-f_old|)
    double delta = new_fitness - bats[i].fitness;
    double p = exp(-l * fabs(delta));
    if (p > r) {
      bats[i].solution = new_solution;
      bats[i].fitness = new_fitness;
    } else {
      free(new_solution);
    }
  }
}
// Calculate the total distance of a solution for the TSP


double calculate_distance(double *solution, City *cities, int num_cities) {
  double distance = 0;
  int i;
  for (i = 0; i < num_cities - 1; i++) {
    double dx = cities[(int)solution[i]].x - cities[(int)solution[i+1]].x;
    double dy = cities[(int)solution[i]].y - cities[(int)solution[i+1]].y;
    distance += sqrt(dx*dx + dy*dy);
  }
  return distance;
}

// Copy the elements of src to dest
void copy_solution(double *dest, double *src, int num_cities) {
	int i;
  for (i = 0; i < num_cities; i++) {
    dest[i] = src[i];
  }
}
// Shuffle the elements of an array
void shuffle(double *array, int num_elements) {
	int i;
  for (i = 0; i < num_elements; i++) {
    int j = rand() % num_elements;
    int temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
}
// Check if any of the new solutions is the best solution so far
int is_new_best_solution(Bat *bats, int num_bats, double *best_solution, double *best_fitness,int *best_num_bat) {
	int i;
  for (i = 0; i < num_bats; i++) {
    if (bats[i].fitness < *best_fitness) {
      *best_fitness = bats[i].fitness;
      *best_num_bat = i;
      return 1;
    }
  }
  return 0;
}
