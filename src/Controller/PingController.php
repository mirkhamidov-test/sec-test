<?php

namespace App\Controller;

use DateTimeImmutable;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class PingController extends AbstractController
{
    #[Route('/ping', methods: [Request::METHOD_GET, Request::METHOD_POST])]
    public function ping(): JsonResponse
    {
        return $this->json($this->generateServerTime());
    }

    #[Route('/', methods: [Request::METHOD_GET, Request::METHOD_POST])]
    public function home(): JsonResponse
    {
        return $this->json($this->generateServerTime());
    }

    private function generateServerTime(): array
    {
        $now = new DateTimeImmutable();

        return [
            'datetime' => $now->format('c'),
            'timestamp' => $now->getTimestamp(),
        ];
    }
}
