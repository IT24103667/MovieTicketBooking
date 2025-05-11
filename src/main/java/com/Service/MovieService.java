package com.Service;

import com.Model.Movie;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class MovieService {
    private static final String FILE_PATH = "./db/Movies.txt";

    public boolean addMovie(Movie movie) {
        try {


            if (movie.getId() == null || movie.getId().isEmpty()) {
                movie.setId(UUID.randomUUID().toString());
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
                writer.write(movie.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();

        File file = new File(FILE_PATH);


        if (!file.exists()) {
            System.err.println("Error: Movies file does not exist at: " + file.getAbsolutePath());
            return movies;
        }


        if (!file.canRead()) {
            System.err.println("Error: Cannot read movies file. Check file permissions.");
            return movies;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            System.out.println("Successfully opened movies file");
            String line;
            int lineNumber = 0;

            while ((line = reader.readLine()) != null) {
                lineNumber++;
                line = line.trim();



                if (line.isEmpty()) {
                    continue;
                }
                try {
                    Movie movie = Movie.fromString(line);
                    if (movie != null) {
                        movies.add(movie);
                    } else {
                        System.err.println("Failed to parse line " + lineNumber + ": returned null");
                    }
                } catch (Exception e) {
                    System.err.println("Error parsing line " + lineNumber + ": " + line);
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading movies file:");
            e.printStackTrace();
        }
        return movies;
    }

    public boolean deleteMovie(String movieId) {
        List<Movie> movies = getAllMovies();
        boolean removed = movies.removeIf(movie -> movie.getId().equals(movieId));

        if (removed) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
                for (Movie movie : movies) {
                    writer.write(movie.toString());
                    writer.newLine();
                }
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    private boolean writeAllMovies(List<Movie> movies) {
        File file = new File(FILE_PATH);


        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            for (Movie movie : movies) {
                writer.write(movie.toString());
                writer.newLine();
            }
            return true;
        } catch (IOException e) {
            System.err.println("Error writing movies file:");
            e.printStackTrace();
            return false;
        }
    }

    public Movie getMovieById(String id) {
        return getAllMovies().stream()
                .filter(m -> m.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public boolean updateMovie(Movie updatedMovie) {
        List<Movie> movies = getAllMovies();
        movies.removeIf(m -> m.getId().equals(updatedMovie.getId()));
        movies.add(updatedMovie);
        return writeAllMovies(movies);
    }

    public String getMovieImageLink(String movieId) {
        return getAllMovies().stream()
                .filter(movie -> movie.getId().equals(movieId))
                .findFirst()
                .map(Movie::getImgLink)
                .orElse(null);
    }
}