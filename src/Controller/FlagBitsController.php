<?php

declare(strict_types=1);

namespace App\Controller;

use App\Repository\TransactionsRepository;
use App\Security\AccessTokenValidator;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/api/flag_bits')]
class FlagBitsController extends AbstractController
{
    public function __construct(
        private readonly AccessTokenValidator $accessTokenValidator,
        private readonly RequestStack $requestStack,
        private readonly TransactionsRepository $transactionsRepository,
    ) {
        $this->accessTokenValidator->validate($this->requestStack->getCurrentRequest());
    }

    #[Route('/{transactionId<\d+>}', methods: Request::METHOD_GET)]
    public function listFlagBitsForTransaction(int $transactionId): JsonResponse
    {
        return $this->json($this->transactionsRepository->findFlagBitsByTransId($transactionId));
    }
}
