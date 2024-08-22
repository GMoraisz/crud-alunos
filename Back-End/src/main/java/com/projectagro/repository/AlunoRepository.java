package com.projectagro.repository;

import com.projectagro.model.Aluno;
import org.springframework.data.jpa.repository.JpaRepository;



public interface AlunoRepository extends JpaRepository<Aluno, Long> {
}
